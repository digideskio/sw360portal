/*
 * Copyright Siemens AG, 2013-2015. Part of the SW360 Portal Project.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
package com.siemens.sw360.components;

import com.siemens.sw360.datahandler.thrift.components.ComponentService;
import org.apache.thrift.protocol.TCompactProtocol;
import com.siemens.sw360.projects.Sw360ThriftServlet;

import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Thrift Servlet instantiation
 *
 * @author cedric.bodet@tngtech.com
 * @author Johannes.Najjar@tngtech.com
 * @author Andreas.Reichel@tngtech.com
 */
public class ComponentServlet extends Sw360ThriftServlet {

    public ComponentServlet() throws IOException {
        // Create a service processor using the provided handler
        super(new ComponentService.Processor<>(new ComponentHandler()), new TCompactProtocol.Factory());
    }
}
