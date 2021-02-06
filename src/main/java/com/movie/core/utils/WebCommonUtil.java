package com.movie.core.utils;

import com.movie.core.constant.WebConstant;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Component
public class WebCommonUtil {
    public static void addRedirectMessage(HttpServletRequest request, Map<String, String> mapMessage, String message) {
        if (StringUtils.isNotBlank(message) && message.equals(WebConstant.REDIRECT_INSERT)) {
            request.setAttribute(WebConstant.MESSAGE_RESPONSE, mapMessage.get(WebConstant.REDIRECT_INSERT));
            request.setAttribute(WebConstant.ALERT, WebConstant.TYPE_SUCCESS);
        } else if (StringUtils.isNotBlank(message) && message.equals(WebConstant.REDIRECT_UPDATE)) {
            request.setAttribute(WebConstant.MESSAGE_RESPONSE, mapMessage.get(WebConstant.REDIRECT_UPDATE));
            request.setAttribute(WebConstant.ALERT, WebConstant.TYPE_SUCCESS);
        } else if (StringUtils.isNotBlank(message) && message.equals(WebConstant.REDIRECT_ERROR)) {
            request.setAttribute(WebConstant.MESSAGE_RESPONSE, mapMessage.get(WebConstant.REDIRECT_ERROR));
            request.setAttribute(WebConstant.ALERT, WebConstant.TYPE_ERROR);
        } else if (StringUtils.isNotBlank(message) && message.equals(WebConstant.REDIRECT_DELETE)) {
            request.setAttribute(WebConstant.MESSAGE_RESPONSE, mapMessage.get(WebConstant.REDIRECT_DELETE));
            request.setAttribute(WebConstant.ALERT, WebConstant.TYPE_SUCCESS);
        } else {
            request.setAttribute(WebConstant.MESSAGE_RESPONSE, mapMessage.get(message));
            request.setAttribute(WebConstant.ALERT, WebConstant.TYPE_ERROR);
        }
    }
}
