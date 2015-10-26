#####################################################
# Schema Design                                     #
#####################################################

Products = new Meteor.Collection 'products'

Schemas.Product = new SimpleSchema
  productId:
    type: String
    label: '상품번호'
  title:
    type: String
    label: '제목'
  category1:
    type: String
    label: '대분류'
  category2:
    type: String
    label: '소분류'
  thumbnail:
    type: String
    label: '썸네일'
  content:
    type: String
    label: '본문'
  createdAt:
    type: Date
    autoValue: -> if this.isInsert then new Date()
    label: '등록일시'
  updatedAt:
    type: Date
    autoValue: -> if this.isUpdate or this.isInsert then new Date()
    label: '변경일시'

Products.helpers {}

Products.attachSchema Schemas.Product

#####################################
# Publish / Subscribe               #
#####################################

if Meteor.isServer
  Meteor.publish 'products', ->
    Products.find {}

if Meteor.isClient
  Meteor.subscribe 'products'

#####################################
# Allow / Deny                      #
#####################################

Products.allow
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc, fieldNames, modifier) ->
    true

#####################################
# Exports                           #
#####################################

@Products = Products
