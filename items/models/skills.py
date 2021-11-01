from typing import List

from models.mixins import *

from models.attributes import Attribute

class Skill(ID_Mixin, Name_Mixin, Description_Mixin):
    """Associated Skill"""
    attributes: List[Attribute]
    """List of `Attribute`s of this `Skill`"""

class Skills_Mixin:
    skills: List[Skill]
    """List of (required) `Skill`s"""