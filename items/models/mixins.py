from datetime import datetime, timedelta

class ID_Mixin:
    id: int
    """`ID` of this object"""

class Name_Mixin:
    name: str
    """`name` of this object"""

class Description_Mixin:
    description: str
    """`description` of this object"""

class Timestamp_Mixin:
    timestamp: datetime
    """`Timestamp` when this `Transaction` happened"""

class Cooldown_Mixin:
    cooldown: timedelta
    """`cooldown` of using this object"""

class Quantity_Mixin:
    quantity: float
    """`Quantity` in this `Inventory`"""
