from flask_sqlalchemy import SQLAlchemy 
import datetime 
import hashlib 
import os 
import bcrypt 


db = SQLAlchemy()

class User(db.Model):
    """
    User Model
    """
    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key=True,autoincrement=True)
    name = db.Column(db.String, nullable=True)
    bank_balance = db.Column(db.Integer, nullable=True)
    dark = db.Column(db.Boolean, nullable=True)
    quiet = db.Column(db.Boolean, nullable=True)
    region = db.Column(db.String, nullable=True)
    # User information
    email = db.Column(db.String, nullable=False, unique=True)
    password_digest = db.Column(db.String, nullable=False)

    # Session information
    session_token = db.Column(db.String, nullable=False, unique=True)
    session_expiration = db.Column(db.DateTime, nullable=False)
    update_token = db.Column(db.String, nullable=False, unique=True)

    def __init__(self, **kwargs):
        """
        Assigning values to different fields of a user record
        """
        self.name = kwargs.get("name","")
        self.bank_balance = kwargs.get("bank_balance",0)
        self.dark = kwargs.get("dark", False)
        self.quiet = kwargs.get("quiet", False)
        self.region = kwargs.get("region","")
        self.email = kwargs.get("email")
        self.password_digest = bcrypt.hashpw(kwargs.get("password").encode("utf8"), bcrypt.gensalt(rounds=13))
        self.renew_session()


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

    def _urlsafe_base_64(self):
        """
        Randomly generates hashed tokens (used for session/update tokens)
        """
        return hashlib.sha1(os.urandom(64)).hexdigest()

    def renew_session(self):
        """
        Renews the sessions, i.e.
        1. Creates a new session token
        2. Sets the expiration time of the session to be a day from now
        3. Creates a new update token
        """
        self.session_token = self._urlsafe_base_64()
        self.session_expiration = datetime.datetime.now() + datetime.timedelta(days=1)
        self.update_token = self._urlsafe_base_64()

    def verify_password(self, password):
        """
        Verifies the password of a user
        """
        return bcrypt.checkpw(password.encode("utf8"), self.password_digest)

    def verify_session_token(self, session_token):
        """
        Verifies the session token of a user
        """
        return session_token == self.session_token and datetime.datetime.now() < self.session_expiration

    def verify_update_token(self, update_token):
        """
        Verifies the update token of a user
        """
        return update_token == self.update_token


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
    occupier = db.Column(db.Integer, db.ForeignKey("user.id"), nullable=False)

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
        self.occupier = kwargs.get("occupier")


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
            "region" : self.region,
            "occupier": User.query.filter_by(id=self.user).first().serialize()
        }

    def simple_serialize(self):
        """
        Returns a dictionary of all fields of a location - except occupier
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
