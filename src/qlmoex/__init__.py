from importlib import metadata as _m

from ._moex_gcurve import MoexGCurve  # type: ignore

__all__ = ["MoexGCurve", "__version__"]
__version__ = _m.version(__name__)
