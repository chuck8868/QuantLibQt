
/*
 * Copyright (C) 2000-2001 QuantLib Group
 *
 * This file is part of QuantLib.
 * QuantLib is a C++ open source library for financial quantitative
 * analysts and developers --- http://quantlib.org/
 *
 * QuantLib is free software and you are allowed to use, copy, modify, merge,
 * publish, distribute, and/or sell copies of it under the conditions stated
 * in the QuantLib License.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE. See the license for more details.
 *
 * You should have received a copy of the license along with this file;
 * if not, please email quantlib-users@lists.sourceforge.net
 * The license is also available at http://quantlib.org/LICENSE.TXT
 *
 * The members of the QuantLib Group are listed in the Authors.txt file, also
 * available at http://quantlib.org/group.html
*/

/*! \file floatingratecoupon.cpp
    \brief Coupon at par on a term structure

    \fullpath
    ql/CashFlows/%floatingratecoupon.cpp
*/

// $Id$

#include "ql/CashFlows/floatingratecoupon.hpp"
#include "ql/Indexes/xibormanager.hpp"

namespace QuantLib {

    using Indexes::Xibor;
    using Indexes::XiborManager;

    namespace CashFlows {

        FloatingRateCoupon::FloatingRateCoupon(double nominal,
          const Handle<Xibor>& index, 
          const RelinkableHandle<TermStructure>& termStructure,
          const Date& startDate, const Date& endDate,
          Spread spread, 
          const Date& refPeriodStart, const Date& refPeriodEnd)
        : Coupon(nominal, index->calendar(),index->rollingConvention(),
              index->dayCounter(), startDate, endDate,
              refPeriodStart, refPeriodEnd), 
          termStructure_(termStructure), index_(index), spread_(spread) {
            termStructure_.registerObserver(this);
        }

        double FloatingRateCoupon::amount() const {
            QL_REQUIRE(!termStructure_.isNull(),
                "null term structure set to par coupon");
            Date settlementDate = termStructure_->settlementDate();
            if (startDate_ < settlementDate) {
                // must have been fixed
                Rate pastFixing = XiborManager::getHistory(
                    index_->name())[startDate_];
                QL_REQUIRE(pastFixing != Null<double>(),
                    "Missing " + index_->name() + " fixing for " +
                        DateFormatter::toString(startDate_));
                return (pastFixing+spread_)*accrualPeriod()*nominal();
            }
            if (startDate_ == settlementDate) {
                // might have been fixed
                try {
                    Rate pastFixing = XiborManager::getHistory(
                        index_->name())[startDate_];
                    if (pastFixing != Null<double>())
                        return (pastFixing+spread_) * 
                            accrualPeriod() * nominal();
                    else
                        ;   // fall through and forecast
                } catch (Error&) {
                    ;       // fall through and forecast
                }
            }
            DiscountFactor startDiscount =
                termStructure_->discount(startDate_);
            DiscountFactor endDiscount =
                termStructure_->discount(endDate_);
            if (spread_ == 0.0)
                return (startDiscount/endDiscount-1.0) * nominal();
            else
                return ((startDiscount/endDiscount-1.0) +
                    spread_*accrualPeriod()) * nominal();
        }

    }

}

