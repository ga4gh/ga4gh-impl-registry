package org.ga4gh.registry.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SpaController {

    /**
     * Forwards all React Router paths to index.html so the app
     * handles routing client-side. Matches paths without a dot
     * (i.e. not static files like .js, .css, .ico).
     */
    @RequestMapping(value = "/{path:[^\\.]*}")
    public String forwardToIndex() {
        return "forward:/index.html";
    }
}
