/*
    $Id$
*/

// $Source$
// $Log$
// Revision 1.8  2001/06/01 16:50:16  lballabio
// Term structure on deposits and swaps
//
// Revision 1.7  2001/05/31 14:48:10  lballabio
// Worked around Visual C++ deficiencies
//
// Revision 1.6  2001/05/24 15:38:07  nando
// smoothing #include xx.hpp and cutting old Log messages
//


#ifndef quantlib_config_msvc_h
#define quantlib_config_msvc_h

#pragma warning(disable: 4786)  // identifier truncated in debug info
#pragma warning(disable: 4190)  // C-linkage of SWIG wrappers

/* So nobody using MSVC needs to specify the .lib in their Makefile any
   more (other compilers will still need to do so)
*/
#ifdef QL_DEBUG
    #pragma comment(lib,"QuantLib_d.lib")
#else
    #pragma comment(lib,"QuantLib.lib")
#endif

#define REQUIRES_DUMMY_RETURN

#define HAVE_CMATH
#define QL_SQRT   sqrt
#define QL_FABS   fabs
#define QL_EXP    exp
#define QL_LOG    log
#define QL_SIN    sin
#define QL_COS    cos
#define QL_POW    pow
#define QL_MODF   modf

#define HAVE_LIMITS

#define HAVE_CTIME
#define QL_CLOCK    clock

#define HAVE_CCTYPE
#define QL_STRLEN   strlen
#define QL_TOLOWER  tolower
#define QL_TOUPPER  toupper

#define QL_MIN      std::_cpp_min
#define QL_MAX      std::_cpp_max

#define BROKEN_TEMPLATE_SPECIALIZATION
#define BROKEN_TEMPLATE_METHOD_CALLS
#define HAVE_EXPRESSION_TEMPLATES
#define HAVE_TEMPLATE_METAPROGRAMMING

#define HAVE_INCOMPLETE_ITERATOR_SUPPORT
#define GARBLED_REVERSE_ITERATOR

#define QL_PATCH_MICROSOFT_BUGS


#endif
