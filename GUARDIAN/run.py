
from routesfile.routes import app
from flask_socketio import SocketIO


if __name__ == "__main__": #Quickcheck to make sure that we only run this script first
    app.run(debug=True)
