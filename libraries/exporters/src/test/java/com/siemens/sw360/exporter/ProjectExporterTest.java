/*
 * Copyright Siemens AG, 2013-2015. Part of the SW360 Portal Project.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
package com.siemens.sw360.exporter;

import org.junit.Test;

import static org.hamcrest.core.Is.is;
import static org.junit.Assert.*;

/**
 * Created by heydenrb on 06.11.15.
 */
public class ProjectExporterTest {

    @Test
    public void testEveryRenderedFieldHasAHeader() throws Exception {
        assertThat(ProjectExporter.RENDERED_FIELDS.size(), is(ProjectExporter.HEADERS.size()));
    }
}
