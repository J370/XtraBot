#FORMS FOR GUARDIANS BIN AND HOST

from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, BooleanField, IntegerField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError
from routesfile.routes import CommandNumber, RequestNumber



class RequestForm(FlaskForm):
    RequestNumber = IntegerField('RequestNumber', validators=[DataRequired()])
    Request = StringField('Request', validators=[DataRequired()])

    submit = SubmitField('Send')



class CommandForm(FlaskForm):
    RequestNumber = IntegerField('RequestNumber', validators=[DataRequired()])
    Request = StringField('Request', validators=[DataRequired()])

    submit = SubmitField('Send')


                          
