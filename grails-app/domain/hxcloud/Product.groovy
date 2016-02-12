package hxcloud

/**
 * Created by hawk on 2/12/16.
 */
class Product {

    Integer productType
    String title
    String productDesc
    String imagePath
    Float price
    Float agentPrice
    Long userId
    Integer status

    enum ProductStatus{
        FINISH, APPROVE, RELEASE, DSIABLED
    }

    enum AttributeType{
        SMS, DATA, VOICE
    }
}
