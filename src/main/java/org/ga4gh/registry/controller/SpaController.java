package org.ga4gh.registry.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SpaController {

    /**
     * Forwards all non-API, non-static requests to index.html
     * so React Router can handle client-side routing.
     * 
     * Matches anything that:
     *  - does not start with /api
     *  - does not contain a dot (i.e. is not a static file like .js, .css, .ico)
     */
    @RequestMapping(value = {
        "/",
        "/service-info",
        "/standards",
        "/services",
        "/deployments",
        "/organisations",
        "/register"
    })
    public String forwardToIndex() {
        return "forward:/index.html";
    }
}