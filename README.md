# quantlib-moex

QuantLib extension for Moscow Exchange (MOEX) specifics – starting with the
zero-coupon yield curve ("G-curve") implemented as `qlmoex.MoexGCurve`.

## Installation

```bash
pip install quantlib-moex
```

The package comes with QuantLib statically linked, so no separate QuantLib installation is required.

## Versioning and Compatibility

This package follows a versioning scheme that reflects compatibility with QuantLib:

- **Version format**: `X.Y.Z.postN` where `X.Y.Z` matches the QuantLib version
- **Current version**: `1.38.0.post0` - compatible with QuantLib 1.38.x
- **Python dependency**: `QuantLib-Python==1.38.*` - ensures ABI and runtime compatibility

### Why this versioning scheme?

1. **ABI Compatibility**: The package is built against a specific QuantLib version and uses the same C++ ABI
2. **Runtime Compatibility**: QuantLib-Python must match the QuantLib version for proper object interoperability
3. **Static Linking**: QuantLib is statically linked into the package, ensuring consistent behavior across platforms

### Upgrading

When upgrading quantlib-moex:
- The QuantLib-Python dependency will be automatically updated to the matching version
- Your existing code should continue to work without changes
- Check the QuantLib changelog for any breaking changes in the underlying library

## Example

```python
import QuantLib as ql
from qlmoex import MoexGCurve

today = ql.Date(7, 6, 2025)
curve = MoexGCurve(today, 0.0095, -0.018, 0.025, 1.5,
                   [0.0002, -0.00015, 0.00005])

print(curve.discount(5.0))
```

## Building from Source

The package uses a modern build system with scikit-build-core and CMake:

```bash
git clone --recursive https://github.com/kostrse/quantlib-moex.git
cd quantlib-moex
pip install -e .
```

Note: QuantLib is included as a git submodule and built statically, so no system QuantLib installation is needed.
