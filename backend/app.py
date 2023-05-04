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
  user_old = json.loads((get_user(user_id))[0])
  print(user_old)
  body = json.loads(request.data)
  user = User(
    name = body.get("name",user_old.get("name")),
    bank_balance = int(body.get("bank_balance",user_old.get("bank_balance"))), 
    dark = bool(body.get("dark",user_old.get("dark"))),
    quiet = body.get("quiet", user_old.get("quiet")),
    region = body.get("region",user_old.get("region"))
  )
  db.session.add(user)
  db.session.commit()
  return success_response(user.serialize(), 201)



if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)

