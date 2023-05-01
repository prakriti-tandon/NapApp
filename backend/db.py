from flask_sqlalchemy import SQLAlchemy 

db = SQLAlchemy()

class User(db.Model):
    """
    User Model
    """
    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key=True,autoincrement=True)
    name = db.Column(db.String, nullable=False)
    bank_balance = db.Column(db.Integer, nullable=True)
    dark = db.Column(db.Boolean, nullable=False)
    quiet = db.Column(db.Boolean, nullable=False)
    region = db.Column(db.String, nullable=False)

    def __init__(self, **kwargs):
        """
        Assigning values to different fields of a user record
        """
        self.name = kwargs.get("name","")
        self.bank_balance = kwargs.get("bank_balance",0)
        self.dark = kwargs.get("dark", False)
        self.quiet = kwargs.get("quiet", False)
        self.region = kwargs.get("region","")


    def serialize(self):
        """
        Returns a dictionary of all fields of user
        """
        return{
            "id" : self.id,
            "name" : self.name,
            "bank_balance":self.bank_balance,
            "dark":self.dark,
            "quiet":self.quiet, 
            "region" : self.region
        }

class Location(db.Model):
    """
    Location Model of possible nap spots
    """
    __tablename__ = "location"
    id = db.Column(db.Integer, primary_key=True,autoincrement=True)
    name = db.Column(db.String, nullable=False)
    address = db.Column(db.String, nullable=False)
    occupied = db.Column(db.Boolean, nullable=False)
    dark = db.Column(db.Boolean, nullable=False)
    quiet = db.Column(db.Boolean, nullable=False)
    region = db.Column(db.String, nullable=False)

    def __init__(self, **kwargs):
        """
        Assigning values to different fields of a location record
        """
        self.name = kwargs.get("name","")
        self.address = kwargs.get("address","")
        self.occupied = kwargs.get("occupied", False)
        self.dark = kwargs.get("dark", False)
        self.quiet = kwargs.get("quiet", False)
        self.region = kwargs.get("region","")


    def serialize(self):
        """
        Returns a dictionary of all fields of a location
        """
        return{
            "id" : self.id,
            "name" : self.name,
            "address" : self.address,
            "occupied" : self.occupied,
            "dark":self.dark,
            "quiet":self.quiet, 
            "region" : self.region
        }
