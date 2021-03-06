/*
 * Copyright Siemens AG, 2015. Part of the SW360 Portal Project.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
package com.siemens.sw360.portal.common.page;

import com.siemens.sw360.portal.common.PortalConstants;

/**
 * @author daniele.fognini@tngtech.com
 */
public enum PortletReleasePage implements PortletPage {
    DETAIL(PortalConstants.PAGENAME_RELEASE_DETAIL),
    EDIT(PortalConstants.PAGENAME_EDIT_RELEASE),
    DUPLICATE(PortalConstants.PAGENAME_DUPLICATE_RELEASE);

    private String pagename;

    PortletReleasePage(String pagename) {
        this.pagename = pagename;
    }

    @Override
    public String pagename() {
        return pagename;
    }
}
