%module _moex_gcurve
%{
#include "moex_gcurve.hpp"
#include <ql/quantlib.hpp>
using namespace QuantLib;
%}

%include "std_vector.i"
%template(DoubleVector) std::vector<double>;

// Apply typemap for Month enum to handle int->Month conversion
%typemap(in) QuantLib::Month {
    if (PyLong_Check($input)) {
        $1 = static_cast<QuantLib::Month>(PyLong_AsLong($input));
    } else {
        PyErr_SetString(PyExc_TypeError, "Expected integer for Month");
        SWIG_fail;
    }
}

// Only include what we need for MoexGCurve
namespace QuantLib {
    enum Month { 
        January = 1, February = 2, March = 3, April = 4, May = 5, June = 6,
        July = 7, August = 8, September = 9, October = 10, November = 11, December = 12
    };
    
    class Date {
    public:
        Date(int day, Month month, int year);
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
    
    // Simple forward declaration for base class
    class ZeroYieldStructure;
    
    // MoexGCurve interface
    class MoexGCurve : public ZeroYieldStructure {
    public:
        MoexGCurve(const Date& referenceDate,
                   double B1, double B2, double B3, double T1,
                   const std::vector<double>& G,
                   const DayCounter& dc = Actual365Fixed(),
                   const Calendar& cal = NullCalendar());
        
        // Expose the discount method
        double discount(double t) const;
    };
}
