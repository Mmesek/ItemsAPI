from items.models.mixins import ID_Mixin

class Server(ID_Mixin):
    """
    "Realm" Base
    """

class ServerID_Mixin:
    server_id: Server.id
    """`Server.id` where this `Transaction` happend"""
    """`Server.id` of `Server` where `Character` exists"""