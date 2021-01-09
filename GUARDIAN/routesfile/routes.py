''' GUARDIAN HOST WEBSITE '''

RequestNumber = int(0)
CommandNumber = int(0)
from flask import Flask,request, render_template, redirect, url_for, flash, jsonify
from routesfile.forms import RequestForm, CommandForm
from flask_login import login_user, current_user, logout_user ,login_required
from flask_socketio import SocketIO, send, emit
from routesfile import app#, bcrypt
import time
import os
import pyodbc
conn = pyodbc.connect('Driver={ODBC Driver 17 for SQL Server};'
                      'Server=(LocalDb)\DB1;'
                      'Database=GUARDIANS;'
                      'Trusted_Connection=yes;')
cursor = conn.cursor()

app = Flask(__name__)
SECRET_KEY = os.urandom(32)
socketio = SocketIO(app)
#socketio.run(app) #Added for socketio tutorial
app.config['SECRET_KEY'] = SECRET_KEY  
#app.config["CACHE_TYPE"] = "null"
# change to "redis" and restart to cache again

import pusher

pusher_client = pusher.Pusher(
  app_id='1134266',
  key='a6bb9f579d82f4dd4843',
  secret='5248330439b2dc66e599',
  cluster='ap1',
  ssl=True
)



@app.route("/")
def hello():
    
    return render_template('home.html', title="home")




#BIN REQUESTS PAGE
@app.route("/bin", methods=["GET", "POST"])
def bin():
    
    cursor.execute('SELECT * FROM GUARDIANS.dbo.Bin')
    namelessList = []
    
    for i in cursor:
        namelessList.append(i)
        
    data = len(namelessList)
    
    request = RequestForm()
    return render_template('bin.html', title='bin', request=request, namelessList=namelessList, data=data)
    

namelessList = []

@app.route('/message', methods=["POST"])
def message():
    try:
        print(username)
        print(message)
        username = request.form.get('username')
        message = request.form.get('message')

        pusher_client.trigger('chat-channel', 'new-message', {'username' : username, 'message': message})
        return jsonify({'result' : 'success'})
    except:
        return jsonify({'result' : 'failure'})
        
    
    
    
    
    return ' '










#HOST COMMANDS PAGE
@app.route("/host", methods=["GET", "POST"])
def host():
    cursor.execute('SELECT * FROM GUARDIANS.dbo.Host')
    namelessList = []
    
    for i in cursor:
        namelessList.append(i)
        
    data = len(namelessList)
    #data = type(namelessList)
    command = CommandForm()
    return render_template('host.html', title='host', command=command, namelessList=namelessList, data = data)#length=len(cursor)











