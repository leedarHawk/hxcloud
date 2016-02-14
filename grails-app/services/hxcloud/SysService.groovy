package hxcloud

import com.taobao.api.DefaultTaobaoClient
import com.taobao.api.TaobaoClient
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse
import grails.transaction.Transactional

@Transactional
class SysService {

    /**
     * send mobile captcha
     * @param mobile
     * @return
     */
    def sendSMS(String mobile, String captcha) {
        TaobaoClient client = new DefaultTaobaoClient("http://gw.api.taobao.com/router/rest", "23308971", "478dc411ea76b79d914ee9676b2f00b6");
        AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
        req.setExtend("123456");
        req.setSmsType("normal");
        req.setSmsFreeSignName("注册验证");
        req.setSmsParamString("{\"code\":\""+ captcha +"\",\"product\":\"华信通讯云\"}");
        req.setRecNum(mobile);
        req.setSmsTemplateCode("SMS_5077055");
        AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
        System.out.println(rsp.getBody());
    }
}
