#pragma once
#include <ql/termstructures/yield/zeroyieldstructure.hpp>
#include <vector>

namespace QuantLib {

class MoexGCurve : public ZeroYieldStructure {
  public:
    MoexGCurve(const Date& referenceDate,
               double B1, double B2, double B3, double T1,
               const std::vector<double>& G,
               const DayCounter& dc = Actual365Fixed(),
               const Calendar& cal = NullCalendar());

  protected:
    Rate zeroYieldImpl(Time t) const override;

  private:
    double B1_, B2_, B3_, T1_;
    std::vector<double> G_;

    static double A(double t, double T1);
    static double B(double t, double T1);
};

}  // namespace QuantLib
