import pytest

qlmoex = pytest.importorskip("qlmoex")
import QuantLib as ql
from qlmoex import MoexGCurve

def test_curve_smoke():
    today = ql.Date(7, 6, 2025)
    curve = MoexGCurve(today, 0.0095, -0.018, 0.025, 1.5,
                       [0.0002, -0.00015, 0.00005])
    assert curve.discount(0.5) > 0.0
