
/*
 * Copyright (C) 2000-2001 QuantLib Group
 *
 * This file is part of QuantLib.
 * QuantLib is a C++ open source library for financial quantitative
 * analysts and developers --- http://quantlib.sourceforge.net/
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
 * if not, contact ferdinando@ametrano.net
 * The license is also available at http://quantlib.sourceforge.net/LICENSE.TXT
 *
 * The members of the QuantLib Group are listed in the Authors.txt file, also
 * available at http://quantlib.sourceforge.net/Authors.txt
*/

/*! \file ratehelpers.cpp
    \brief rate helpers
    
    $Source$
    $Log$
    Revision 1.4  2001/05/24 11:15:57  lballabio
    Stripped conventions from Currencies

    Revision 1.3  2001/05/17 15:33:30  lballabio
    Deposit rate helpers now use conventions in Currency

    Revision 1.2  2001/05/16 15:45:56  lballabio
    Fixed typo in docs

    Revision 1.1  2001/05/16 09:57:27  lballabio
    Added indexes and piecewise flat forward curve

*/

#include "ql/TermStructures/ratehelpers.hpp"
#include "ql/dataformatters.hpp"

namespace QuantLib {

    namespace TermStructures {

        void RateHelper::setTermStructure(const TermStructure* t) {
            QL_REQUIRE(t != 0, "null term structure given");
            termStructure_ = t;
        }

        
        DepositRateHelper::DepositRateHelper(Rate rate, const Date& settlement, 
            int n, TimeUnit units, const Handle<Calendar>& calendar, 
            bool isAdjusted, bool isModifiedFollowing, 
            const Handle<DayCounter>& dayCounter)
        : rate_(rate), settlement_(settlement), n_(n), units_(units), 
          calendar_(calendar), isAdjusted_(isAdjusted), 
          isModified_(isModifiedFollowing), dayCounter_(dayCounter) {
            maturity_ = settlement_.plus(n_,units_);
            if (isAdjusted_)
                maturity_ = calendar_->roll(maturity_,isModified_);
            yearFraction_ = dayCounter_->yearFraction(settlement_,maturity_);
        }
        
        double DepositRateHelper::rateError() const {
            QL_REQUIRE(termStructure_ != 0, "term structure not set");
            Rate impliedRate = (1.0/termStructure_->discount(maturity_)-1.0) / 
                yearFraction_;
            return rate_-impliedRate;
        }
    
        double DepositRateHelper::discountGuess() const {
            QL_REQUIRE(termStructure_ != 0, "term structure not set");
            return 1.0/(1.0+rate_*yearFraction_);
        }
    
        Date DepositRateHelper::maturity() const {
            QL_REQUIRE(termStructure_ != 0, "term structure not set");
            return maturity_;
        }

    }

}
