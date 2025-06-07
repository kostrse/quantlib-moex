%module _moex_gcurve
%{
#include "moex_gcurve.hpp"
#include <ql/quantlib.hpp>
using namespace QuantLib;
%}

%include "std_vector.i"
%template(DoubleVector) std::vector<double>;

// Basic QuantLib types needed for our interface
namespace QuantLib {
    class Date {
    public:
        Date(int day, int month, int year);
    };
    
    class DayCounter {
    public:
        DayCounter();
    };
    
    class Calendar {
    public:
        Calendar();
    };
    
    class Actual365Fixed : public DayCounter {
    public:
        Actual365Fixed();
    };
    
    class NullCalendar : public Calendar {
    public:
        NullCalendar();
    };
    
    typedef double Time;
    typedef double Rate;
}

%include "moex_gcurve.hpp"
