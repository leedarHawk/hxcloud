package hxcloud

class ProductAttribute {

    String name
    Integer attributeType
    Date updateTime = new Date()

    enum AttributeType{
        SMS, DATA, VOICE
    }

    static constraints = {
    }
}
