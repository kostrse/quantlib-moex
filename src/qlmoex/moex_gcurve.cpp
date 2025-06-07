#include "moex_gcurve.hpp"
#include <cmath>

using namespace QuantLib;

MoexGCurve::MoexGCurve(const Date& ref,
                       double B1, double B2, double B3, double T1,
                       const std::vector<double>& G,
                       const DayCounter& dc,
                       const Calendar& cal)
    : ZeroYieldStructure(ref, cal, dc),
      B1_(B1), B2_(B2), B3_(B3), T1_(T1), G_(G) {}

double MoexGCurve::A(double t, double T1) {
    return (1.0 - std::exp(-t / T1)) / (t / T1);
}
double MoexGCurve::B(double t, double T1) {
    return A(t, T1) - std::exp(-t / T1);
}

Rate MoexGCurve::zeroYieldImpl(Time t) const {
    if (t <= 0.0) return B1_;
    double r = B1_ + B2_ * A(t, T1_) + B3_ * B(t, T1_);
    for (std::size_t k = 0; k < G_.size(); ++k)
        r += G_[k] * std::pow(t, static_cast<int>(k + 1));
    return r;
}
