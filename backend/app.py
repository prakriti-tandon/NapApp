from db import db 
from flask import Flask, request 
from db import User 
from db import Location 
import json 
import os 

app = Flask(__name__)
db_filename = "nap.db" 


app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()

# generalized response formats
def success_response(data, code=200):
    return json.dumps(data), code


def failure_response(message, code=404):
    return json.dumps({"error": message}), code

############## USER ENDPOINTS ####################
@app.route("/api/users/")
def get_users():
  """
  Endpint to get all users 
  """
  users = [user.serialize() for user in User.query.all()]
  return success_response({"users": users},200)


@app.route("/api/users/<int:user_id>")
def get_user(user_id):
  """
  Endpoint to get a user by id 
  """
  user = User.query.filter_by(id=user_id).first()
  if user is None:
    return failure_response("User not found")
  return success_response(user.serialize())


@app.route("/api/users/",methods=["POST"])
def create_user():
  """
  Endpoint to create a user
  """
  body = json.loads(request.data)
  if body.get("name") is None or body.get("region") is None: 
    return failure_response("incorrect input", 400)
  user = User(
    name = body.get("name"),
    bank_balance = 500, 
    dark = bool(body.get("dark",True)),
    quiet = bool(body.get("quiet", True)),
    region = body.get("region")
  )
  db.session.add(user)
  db.session.commit()
  return success_response(user.serialize(), 201)

@app.route("/api/users/<int:user_id>/", methods=["DELETE"])
def delete_user(user_id):
    """
    Endpoint for deleting a user by id
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found")
    db.session.delete(user)
    db.session.commit()
    return success_response(user.serialize())

@app.route("/api/users/update/<int:user_id>/",methods=["POST"])
def update_user(user_id):
  """
  Endpoint to update one or more fields of a user
  """
  user = User.query.filter_by(id=user_id).first()
  if user is None:
        return failure_response("User not found!")
  body = json.loads(request.data)
  user.name = body.get("name",user.name)
  user.bank_balance = int(body.get("bank_balance",user.bank_balance)) 
  user.dark = bool(body.get("dark",user.dark))
  user.quiet = body.get("quiet", user.quiet)
  user.region = body.get("region",user.region)
  db.session.commit()
  return success_response(user.serialize(), 201)

############## LOCATION ENDPOINTS ####################
@app.route("/api/locations/")
def get_locations():
  """
  Endpoint to get all locations
  """
  locations = [loc.serialize() for loc in Location.query.all()]
  if locations is None:
        return failure_response("Locations not found in region")
  return success_response({"locations": locations},200)

@app.route("/api/locations/<int:loc_id>/")
def get_location(loc_id):
  """
  Endpoint to get a location by id 
  """
  loc = Location.query.filter_by(id=loc_id).first()
  if loc is None:
    return failure_response("Location not found")
  return success_response(loc.serialize())

@app.route("/api/locations/<string:loc_region>/")
def get_location_by_region(loc_region):
  """
  Endpoint to get all locations within a specifc region
  """
  # if Location.query.filter_by(region=loc_region) is not None:
  #       return failure_response(loc_region)
  locations = [loc.serialize() for loc in Location.query.filter_by(region=loc_region)]
  if locations is None:
        return failure_response("Locations not found in region")
  return success_response({"locations": locations},200)

@app.route("/api/locations/",methods=["POST"])
def create_location():
  """
  Endpoint to create a location
  """
  body = json.loads(request.data)
  if body.get("building") is None or body.get("room") is None or body.get("region") is None: 
    return failure_response("incorrect input", 400)
  loc = Location(
    building = body.get("building"),
    room = body.get("room"),
    occupied = False,
    dark = bool(body.get("dark",True)),
    quiet = bool(body.get("quiet", True)),
    region = body.get("region")
  )
  # Occupier_id of 0 means that no user is assigned to that location
  db.session.add(loc)
  db.session.commit()
  return success_response(loc.serialize(), 201)

@app.route("/api/locations/<string:is_dark>/<string:is_quiet>/")
def get_location_by_preferences(is_dark, is_quiet):
  """
  Endpoint to get all locations with given preferences
  """
  # if Location.query.filter_by(region=loc_region) is not None:
  #       return failure_response(loc_region)
  is_dark = True if (str.lower(is_dark) == "true") else False
  is_quiet = True if (str.lower(is_quiet) == "true") else False
  locations = [loc.serialize() for loc in Location.query.filter_by(dark=is_dark, quiet=is_quiet)]
  if locations is None:
        return failure_response("Locations not found with given preferences")
  return success_response({"locations": locations},200)

@app.route("/api/locations/<int:loc_id>/<int:user_id>/",methods=["POST"])
def update_location_occupancy(loc_id, user_id):
  """
  Endpoint to update location occupancy
  """
  user = User.query.filter_by(id=user_id).first()
  loc = Location.query.filter_by(id=loc_id).first()
  if user_id > 0 and user is None:
    return failure_response("User does not exist!")
  if loc is None:
    return failure_response("Location does not exist!")
  loc.occupier_id = user_id
  if (user_id == 0):
    loc.occupied = False
  else:
    loc.occupied = True
  db.session.commit()
  return success_response(loc.serialize(), 201)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)


