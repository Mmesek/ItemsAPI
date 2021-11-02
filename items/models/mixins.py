from datetime import datetime, timedelta


class ID_Mixin:
    id: int = 0
    """`ID` of this object"""


class Name_Mixin:
    name: str = ""
    """`name` of this object"""


class Description_Mixin:
    description: str = ""
    """`description` of this object"""


class Timestamp_Mixin:
    timestamp: datetime = None
    """`Timestamp` when this `Transaction` happened"""


class Cooldown_Mixin:
    cooldown: timedelta = None
    """`cooldown` of using this object"""


class Quantity_Mixin:
    quantity: float = 0.0
    """`Quantity` in this `Inventory`"""
