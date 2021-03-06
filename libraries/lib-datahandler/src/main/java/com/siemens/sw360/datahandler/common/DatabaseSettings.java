/*
 * Copyright Siemens AG, 2014-2016. Part of the SW360 Portal Project.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
package com.siemens.sw360.datahandler.common;

import java.util.Properties;

/**
 * Constants for the database address
 *
 * @author cedric.bodet@tngtech.com
 * @author stefan.jaeger@evosoft.com
 */
public class DatabaseSettings {

    public static final String PROPERTIES_FILE_PATH = "/couchdb.properties";

    public static final String COUCH_DB_URL;
    public static final String COUCH_DB_DATABASE;
    public static final String COUCH_DB_ATTACHMENTS;
    public static final String COUCH_DB_FOSSOLOGY;
    public static final String COUCH_DB_USERS;
    public static final String COUCH_DB_VM;

    public static final int LUCENE_SEARCH_LIMIT;

    static {
        Properties props = CommonUtils.loadProperties(DatabaseSettings.class, PROPERTIES_FILE_PATH);

        COUCH_DB_URL = props.getProperty("couchdb.url", "http://localhost:5984");
        COUCH_DB_DATABASE = props.getProperty("couchdb.database", "sw360db");
        COUCH_DB_USERS = props.getProperty("couchdb.usersdb", "sw360users");
        COUCH_DB_ATTACHMENTS = props.getProperty("couchdb.attachments", "sw360attachments");
        COUCH_DB_FOSSOLOGY = props.getProperty("couchdb.fossologyKeys", "sw360fossologyKeys");
        COUCH_DB_VM = props.getProperty("couchdb.vulnerability_management", "sw360vm");

        LUCENE_SEARCH_LIMIT = Integer.parseInt(props.getProperty("lucenesearch.limit", "25"));
    }


    private DatabaseSettings() {
        // Utility class with only static functions
    }

}
