QT      -= core gui
TEMPLATE = app
CONFIG += console
CONFIG -= qt
CONFIG  *= link_pri


# Boost Library
win32 {
    INCLUDEPATH += C:/boost/boost/boost_1_50_0
    CONFIG(debug, debug|release) {
        LIBS += C:/boost/boost_1_50_0/lib/x86/libboost_timer-vc100-mt-gd-1_50.lib
    } else {
        LIBS += C:/boost/boost_1_50_0/lib/x86/libboost_timer-vc100-mt-1_50.lib
    }
}
unix {
    INCLUDEPATH += /home/deriversatile/boost/boost_1_50_0
    CONFIG(debug, debug|release) {
        LIBS += -L/home/deriversatile/boost/boost_1_50_0/lib -lboost_timer-mt
        LIBS += -L/home/deriversatile/boost/boost_1_50_0/lib -lboost_unit_test_framework-mt
    } else {
        LIBS += -L/home/deriversatile/boost/boost_1_50_0/lib -lboost_timer-mt
        LIBS += -L/home/deriversatile/boost/boost_1_50_0/lib -lboost_unit_test_framework-mt
    }
}

# QuantLib
win32 {
    INCLUDEPATH += C:/QuantLib/QuantLibQt
    CONFIG(debug, debug|release) {
        LIBS += C:/QuantLib/QuantLibQt/lib/QuantLib-vc100-mt-gd.lib
    } else {
        LIBS += C:/QuantLib/QuantLibQt/lib/QuantLib-vc100-mt.lib
    }
}
unix {
    INCLUDEPATH += /home/deriversatile/QuantLib/QuantLibQt
    CONFIG(debug, debug|release) {
        LIBS += -L/home/deriversatile/QuantLib/QuantLibQt/lib -lQuantLibQtd
    } else {
        LIBS += -L/home/deriversatile/QuantLib/QuantLibQt/lib -lQuantLibQt
    }
}


SOURCES += \
    writerextensibleoption.cpp \
    vpp.cpp \
    volatilitymodels.cpp \
    varianceswaps.cpp \
    varianceoption.cpp \
    variancegamma.cpp \
    utilities.cpp \
    transformedgrid.cpp \
    tracing.cpp \
    tqreigendecomposition.cpp \
    timeseries.cpp \
    termstructures.cpp \
    swingoption.cpp \
    swaptionvolatilitymatrix.cpp \
    swaptionvolatilitycube.cpp \
    swaption.cpp \
    swapforwardmappings.cpp \
    swap.cpp \
    surface.cpp \
    stats.cpp \
    spreadoption.cpp \
    solvers.cpp \
    shortratemodels.cpp \
    schedule.cpp \
    sampledcurve.cpp \
    rounding.cpp \
    rngtraits.cpp \
    riskstats.cpp \
    rangeaccrual.cpp \
    quotes.cpp \
    quantooption.cpp \
    quantlibtestsuite.cpp \
    quantlibbenchmark.cpp \
    piecewiseyieldcurve.cpp \
    period.cpp \
    pathgenerator.cpp \
    pagodaoption.cpp \
    overnightindexedswap.cpp \
    optionletstripper.cpp \
    optimizers.cpp \
    operators.cpp \
    nthtodefault.cpp \
    money.cpp \
    mersennetwister.cpp \
    mclongstaffschwartzengine.cpp \
    matrices.cpp \
    marketmodel_smmcaplethomocalibration.cpp \
    marketmodel_smmcapletcalibration.cpp \
    marketmodel_smmcapletalphacalibration.cpp \
    marketmodel_smm.cpp \
    marketmodel_cms.cpp \
    marketmodel.cpp \
    margrabeoption.cpp \
    lowdiscrepancysequences.cpp \
    lookbackoptions.cpp \
    linearleastsquaresregression.cpp \
    libormarketmodelprocess.cpp \
    libormarketmodel.cpp \
    jumpdiffusion.cpp \
    interpolations.cpp \
    interestrates.cpp \
    integrals.cpp \
    instruments.cpp \
    inflationvolatility.cpp \
    inflationcpiswap.cpp \
    inflationcpicapfloor.cpp \
    inflationcapflooredcoupon.cpp \
    inflationcapfloor.cpp \
    inflation.cpp \
    hybridhestonhullwhiteprocess.cpp \
    himalayaoption.cpp \
    hestonmodel.cpp \
    gjrgarchmodel.cpp \
    gaussianquadratures.cpp \
    forwardoption.cpp \
    fdmlinearop.cpp \
    fdheston.cpp \
    fastfouriertransform.cpp \
    factorial.cpp \
    extendedtrees.cpp \
    exchangerate.cpp \
    everestoption.cpp \
    europeanoption.cpp \
    dividendoption.cpp \
    distributions.cpp \
    digitaloption.cpp \
    digitalcoupon.cpp \
    defaultprobabilitycurves.cpp \
    daycounters.cpp \
    dates.cpp \
    curvestates.cpp \
    creditdefaultswap.cpp \
    covariance.cpp \
    convertiblebonds.cpp \
    compoundoption.cpp \
    commodityunitofmeasure.cpp \
    cms.cpp \
    cliquetoption.cpp \
    chooseroption.cpp \
    cdsoption.cpp \
    cdo.cpp \
    cashflows.cpp \
    capflooredcoupon.cpp \
    capfloor.cpp \
    calendars.cpp \
    brownianbridge.cpp \
    bonds.cpp \
    blackdeltacalculator.cpp \
    bermudanswaption.cpp \
    batesmodel.cpp \
    basketoption.cpp \
    barrieroption.cpp \
    autocovariances.cpp \
    assetswap.cpp \
    asianoptions.cpp \
    array.cpp \
    americanoption.cpp

OTHER_FILES += \
    README.txt

HEADERS += \
    writerextensibleoption.hpp \
    vpp.hpp \
    volatilitymodels.hpp \
    varianceswaps.hpp \
    varianceoption.hpp \
    variancegamma.hpp \
    utilities.hpp \
    transformedgrid.hpp \
    tracing.hpp \
    tqreigendecomposition.hpp \
    timeseries.hpp \
    termstructures.hpp \
    swingoption.hpp \
    swaptionvolstructuresutilities.hpp \
    swaptionvolatilitymatrix.hpp \
    swaptionvolatilitycube.hpp \
    swaption.hpp \
    swapforwardmappings.hpp \
    swap.hpp \
    surface.hpp \
    stats.hpp \
    spreadoption.hpp \
    solvers.hpp \
    shortratemodels.hpp \
    schedule.hpp \
    sampledcurve.hpp \
    rounding.hpp \
    rngtraits.hpp \
    riskstats.hpp \
    rangeaccrual.hpp \
    quotes.hpp \
    quantooption.hpp \
    piecewiseyieldcurve.hpp \
    period.hpp \
    pathgenerator.hpp \
    pagodaoption.hpp \
    overnightindexedswap.hpp \
    optionletstripper.hpp \
    optimizers.hpp \
    operators.hpp \
    nthtodefault.hpp \
    money.hpp \
    mersennetwister.hpp \
    mclongstaffschwartzengine.hpp \
    matrices.hpp \
    marketmodel_smmcaplethomocalibration.hpp \
    marketmodel_smmcapletcalibration.hpp \
    marketmodel_smmcapletalphacalibration.hpp \
    marketmodel_smm.hpp \
    marketmodel_cms.hpp \
    marketmodel.hpp \
    margrabeoption.hpp \
    lowdiscrepancysequences.hpp \
    lookbackoptions.hpp \
    linearleastsquaresregression.hpp \
    libormarketmodelprocess.hpp \
    libormarketmodel.hpp \
    jumpdiffusion.hpp \
    interpolations.hpp \
    interestrates.hpp \
    integrals.hpp \
    instruments.hpp \
    inflationvolatility.hpp \
    inflationcpiswap.hpp \
    inflationcpicapfloor.hpp \
    inflationcapflooredcoupon.hpp \
    inflationcapfloor.hpp \
    inflation.hpp \
    hybridhestonhullwhiteprocess.hpp \
    himalayaoption.hpp \
    hestonmodel.hpp \
    gjrgarchmodel.hpp \
    gaussianquadratures.hpp \
    forwardoption.hpp \
    fdmlinearop.hpp \
    fdheston.hpp \
    fastfouriertransform.hpp \
    factorial.hpp \
    extendedtrees.hpp \
    exchangerate.hpp \
    everestoption.hpp \
    europeanoption.hpp \
    dividendoption.hpp \
    distributions.hpp \
    digitaloption.hpp \
    digitalcoupon.hpp \
    defaultprobabilitycurves.hpp \
    daycounters.hpp \
    dates.hpp \
    curvestates.hpp \
    creditdefaultswap.hpp \
    covariance.hpp \
    convertiblebonds.hpp \
    compoundoption.hpp \
    commodityunitofmeasure.hpp \
    cms.hpp \
    cliquetoption.hpp \
    chooseroption.hpp \
    cdsoption.hpp \
    cdo.hpp \
    cashflows.hpp \
    capflooredcoupon.hpp \
    capfloor.hpp \
    calendars.hpp \
    brownianbridge.hpp \
    bonds.hpp \
    blackdeltacalculator.hpp \
    bermudanswaption.hpp \
    batesmodel.hpp \
    basketoption.hpp \
    barrieroption.hpp \
    autocovariances.hpp \
    assetswap.hpp \
    asianoptions.hpp \
    array.hpp \
    americanoption.hpp

