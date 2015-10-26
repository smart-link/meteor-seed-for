#####################################################
# Schema Design                                     #
#####################################################

Users = Meteor.users

Schemas.UserProfile = new SimpleSchema
  userType:
    type: String
    label: '회원구분'
  name:
    type: String
    label: '실명'
  birthday:
    type: Date
    label: '생년월일'
  phone:
    type: String
    label: '전화번호'
  mobile:
    type: String
    label: '휴대전화'
  address:
    type: String
    label: '주소,배송지'
  isRecvEmail:
    type: Boolean
    label: '이메일 수신여부'
  isRecvSMS:
    type: Boolean
    label: 'SMS 수신여부'
  company:
    type: String
    label: '회사명'
  businessRegNum:
    type: String
    label: '사업자번호'
  businessCall:
    type: String
    label: '대표번호'
  staffName:
    type: String
    label: '담당자 이름'
  staffMobile:
    type: String
    label: '담당자 휴대전화'
  staffEmail:
    type: String
    label: '담당자 이메일'

Schemas.User = new SimpleSchema
  username:
    type: String
    regEx: /^[a-z0-9A-Z_]{3,15}$/
    optional: true
  emails:
    type: [Object]
    optional: true
  'emails.$.address':
    type: String
    regEx: SimpleSchema.RegEx.Email
  'emails.$.verified':
    type: Boolean
  createdAt:
    type: Date
  profile:
    type: Schemas.UserProfile
    optional: true
  services:
    type: Object
    optional: true
    blackbox: true
  roles:
    type: [String]
    blackbox: true
    optional: true

# Users::get = (id) ->
#   if Meteor.isServer
#     log 'This is server.'
#   if Meteor.isClient
#     log 'This is client.'
#   Users.findOne (id)

Users.helpers
  email: ->
    @emails[0].address

Users.attachSchema Schemas.User

#####################################
# Publish / Subscribe               #
#####################################

if Meteor.isServer
  Meteor.publish 'users', ->
    Users.find {}

if Meteor.isClient
  Meteor.subscribe 'users'

#####################################
# Allow / Deny                      #
#####################################

Users.allow
  update: (userId, doc, fieldNames, modifier) ->
    userId is doc._id
  remove: (userId, doc, fieldNames, modifier) ->
    userId is doc._id

#####################################
# Exports                           #
#####################################

@Users = Users

@User = -> Meteor.user()
