# quantlib-moex

QuantLib extension for Moscow Exchange (MOEX) specifics – starting with the
zero-coupon yield curve ("G-curve") implemented as `qlmoex.MoexGCurve`.

## Installation

```bash
uv pip install quantlib-moex
```

Requires `QuantLib-Python` pre-installed (same minor version).

## Example

```python
import QuantLib as ql
from qlmoex import MoexGCurve

today = ql.Date(7, 6, 2025)
curve = MoexGCurve(today, 0.0095, -0.018, 0.025, 1.5,
                   [0.0002, -0.00015, 0.00005])

print(curve.discount(5.0))
```
