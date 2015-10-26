#####################################################
# Schema Design                                     #
#####################################################

Orders = new Meteor.Collection 'orders'

Schemas.Order = new SimpleSchema
  orderId:
    type: String
    label: '주문번호'
  category1:
    type: String
    label: '대분류'
  category2:
    type: String
    label: '수분류'
  orderDirection:
    type: String
    label: '주문서작성방향'
  paperType:
    type: String
    label: '용지타입'
  paperGType:
    type: String
    label: '종이선택, g수'
  printColotType:
    type: String
    label: '인쇄도수'
  cuttingWidth:
    type: Number
    label: '규격 재단 사이즈 가로'
  cuttingHeight:
    type: Number
    label: '규격 재단 사이즈 세로'
  workingWidth:
    type: Number
    label: '규격 작업 사이즈 가로'
  workingHeight:
    type: Number
    label: '규격 작업 사이즈 세로'
  count:
    type: Number
    label: '수량'
  bundle:
    type: Number
    label: '수량의 건수, 묶음'
  orderTitle:
    type: String
    label: '주문 제목'
  price:
    type: Number
    label: '인쇄비용'
  optionsPrice:
    type: Number
    label: '후가공비용'
  orderOptions:
    type: Object
    label: '가공옵션'
  createdAt:
    type: Date
    autoValue: -> if this.isInsert then new Date()
    label: '등록일시'
  updatedAt:
    type: Date
    autoValue: -> if this.isUpdate or this.isInsert then new Date()
    label: '변경일시'

Orders.helpers {}

Orders.attachSchema Schemas.Order

#####################################
# Publish / Subscribe               #
#####################################

if Meteor.isServer
  Meteor.publish 'orders', ->
    Orders.find {}

if Meteor.isClient
  Meteor.subscribe 'orders'

#####################################
# Allow / Deny                      #
#####################################

Orders.allow
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc, fieldNames, modifier) ->
    true

#####################################
# Exports                           #
#####################################

@Orders = Orders
