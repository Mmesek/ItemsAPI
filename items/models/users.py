from .mixins import ID_Mixin
from .characters import Character

class User(ID_Mixin):
    """
    `User` Base
    """
    def new_character(self, server = None) -> 'Character':
        """
        Create a new `Character` for this `User`
        """
        return Character(user_id=self.id, server_id=server)

class UserID_Mixin:
    user_id: User.id
    """`User`.`id` this object belongs to"""