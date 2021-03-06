/*
 * Copyright Siemens AG, 2014-2016. Part of the SW360 Portal Project.
 * With modifications by Bosch Software Innovations GmbH, 2016.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
package com.siemens.sw360.exporter;

import com.google.common.collect.ImmutableList;
import com.siemens.sw360.datahandler.common.ThriftEnumUtils;
import com.siemens.sw360.datahandler.thrift.components.ComponentService;
import com.siemens.sw360.datahandler.thrift.components.Release;
import com.siemens.sw360.datahandler.thrift.projects.Project;
import org.apache.log4j.Logger;
import org.apache.thrift.TEnum;
import org.apache.thrift.TException;

import java.util.*;
import java.util.stream.Collectors;

import static com.google.common.base.Strings.nullToEmpty;
import static com.siemens.sw360.datahandler.common.CommonUtils.joinStrings;
import static com.siemens.sw360.datahandler.common.SW360Utils.printName;
import static com.siemens.sw360.datahandler.thrift.projects.Project._Fields.*;

/**
 * Created by bodet on 06/02/15.
 *
 * @author cedric.bodet@tngtech.com
 */
public class ProjectExporter extends ExcelExporter<Project> {


    public static final List<Project._Fields> RENDERED_FIELDS = ImmutableList.<Project._Fields>builder()
            .add(ID)
            .add(NAME)
            .add(STATE)
            .add(CREATED_BY)
            .add(CREATED_ON)
            .add(PROJECT_RESPONSIBLE)
            .add(LEAD_ARCHITECT)
            .add(TAG)
            .add(BUSINESS_UNIT)
            .add(RELEASE_IDS)
            .add(RELEASE_CLEARING_STATE_SUMMARY)
            .add(EXTERNAL_IDS)
            .build();



    private static final Logger log = Logger.getLogger(ProjectExporter.class);

    protected static final List<String> HEADERS = ImmutableList.<String>builder()
            .add("Project ID")
            .add("Project Name")
            .add("Project State")
            .add("Created by")
            .add("Creation Date")
            .add("Project Responsible")
            .add("Project Lead Architect")
            .add("Project Tag")
            .add("Group")
            .add("Release IDs")
            .add("ReleaseClearingStateSummary")
            .add("External Ids")
            .build();

    public ProjectExporter(ComponentService.Iface client) {
        super(new ProjectHelper(client));
    }

    private static class ProjectHelper implements ExporterHelper<Project> {

        private final ComponentService.Iface client;

        private ProjectHelper(ComponentService.Iface client) {
            this.client = client;
        }

        @Override
        public int getColumns() {
            return HEADERS.size();
        }

        @Override
        public List<String> getHeaders() {
            return HEADERS;
        }

        @Override
        public List<String> makeRow(Project project) {
            List<String> row = new ArrayList<>(getColumns());

            for (Project._Fields renderedField : RENDERED_FIELDS) {
                Object fieldValue = project.getFieldValue(renderedField);

                if (renderedField.equals(RELEASE_IDS)) {
                    row.add(joinStrings(getReleases(project.releaseIds)));
                }
                else if (fieldValue instanceof TEnum) {
                    row.add(nullToEmpty(ThriftEnumUtils.enumToString((TEnum) fieldValue)));
                }
                else if (fieldValue instanceof String ) {
                    row.add(nullToEmpty((String) fieldValue));
                }
                else if (fieldValue instanceof Map) {
                    List<String> mapEntriesAsStrings = ((Map <String, String>) fieldValue).entrySet().stream().map(e -> e.getKey() + " : "+ e.getValue()).collect(Collectors.toList());
                    row.add(joinStrings(mapEntriesAsStrings));
                }
                else {
                    row.add("");
                }

            }

            return row;
        }

        private List<String> getReleases(Set<String> ids) {
            if (ids == null) return Collections.emptyList();


            List<Release> releasesByIdsForExport;
            try {
                releasesByIdsForExport = client.getReleasesByIdsForExport(ids);
            } catch (TException e) {
                log.error("Error fetching release information", e);
                releasesByIdsForExport=Collections.emptyList();
            }

            List<String> releaseNames = new ArrayList<>(ids.size());

            for (Release release : releasesByIdsForExport) {
                releaseNames.add(printName(release));
            }

            return releaseNames;
        }
    }

}
