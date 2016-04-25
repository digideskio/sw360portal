/*
 * Copyright Siemens AG, 2014-2015. Part of the SW360 Portal Project.
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License Version 2.0 as published by the
 * Free Software Foundation with classpath exception.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License version 2.0 for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program (please see the COPYING file); if not, write to the Free
 * Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 * 02110-1301, USA.
 */

include "sw360.thrift"
include "components.thrift"
include "projects.thrift"
include "users.thrift"
include "licenses.thrift"

namespace java com.siemens.sw360.datahandler.thrift.moderation
namespace php sw360.thrift.moderation

typedef sw360.RequestStatus RequestStatus
typedef sw360.ModerationState ModerationState
typedef components.Component Component
typedef components.Release Release
typedef projects.Project Project
typedef users.User User
typedef licenses.License License
typedef licenses.Todo Todo

enum DocumentType {
    COMPONENT = 1,
    RELEASE = 2,
    PROJECT = 3,
    LICENSE = 4,
    USER = 5,
}

struct ModerationRequest {

    // Basic information
    1: optional string id,
    2: optional string revision,
    3: optional string type = "moderation",

    // Moderation request
    10: required i64 timestamp,
    11: required string documentId,
    12: required DocumentType documentType,
    13: optional string requestingUser,
    14: optional set<string> moderators,
    15: optional string documentName,
    16: required ModerationState moderationState,
    17: optional string reviewer,
    18: required bool requestDocumentDelete,
    19: optional string requestingUserDepartment;

    // Underlying objects
    20: optional Component componentAdditions,
    21: optional Release releaseAdditions,
    22: optional Project projectAdditions,
    23: optional License licenseAdditions,//only moderation of todos is supported
    24: optional User user,

    30: optional Component componentDeletions,
    31: optional Release releaseDeletions,
    32: optional Project projectDeletions,
    33: optional License licenseDeletions,

}

service ModerationService {

    /**
     * write moderation request for component to database by comparing component with corresponding document in database
     * and writing difference as additions and deletions to moderation request,
     * set requestingUser of moderation request to user
     **/
    RequestStatus createComponentRequest(1: Component component, 2: User user);

    /**
      * write moderation request for release to database by comparing release with corresponding document in database
      * and writing difference as additions and deletions to moderation request,
      * set requestingUser of moderation request to use
      **/
    RequestStatus createReleaseRequest(1: Release release, 2: User user);

    /**
      * write moderation request for project to database by comparing project with corresponding document in database
      * and writing difference as additions and deletions to moderation request,
      * set requestingUser of moderation request to user
      **/
    RequestStatus createProjectRequest(1: Project project, 2: User user);

    /**
      * write moderation request for license to database,
      * only todos and whitelists can be moderated, so license todos are compared with corresponding todos in database,
      * differences are written as additions and deletions to moderation request,
      * set requestingUser of moderation request to user
      **/
    RequestStatus createLicenseRequest(1: License license, 2: User user);

    /**
      * write moderation request for activating a user account to database
      **/
    oneway void createUserRequest(1: User user);

    /**
      * write moderation request for deleting component to database,
      * set requestingUser of moderation request to user
      **/
    oneway void createComponentDeleteRequest(1: Component component, 2: User user);

    /**
      * write moderation request for deleting release to database,
      * set requestingUser of moderation request to user
      **/
    oneway void createReleaseDeleteRequest(1: Release release, 2: User user);

    /**
      * write moderation request for deleting project to database,
      * set requestingUser of moderation request to user
      **/
    oneway void createProjectDeleteRequest(1: Project project, 2: User user);

    /**
     * get list of moderation requests for document with documentId currently present in database
     **/
    list<ModerationRequest> getModerationRequestByDocumentId(1: string documentId);

    ModerationRequest getModerationRequestById(1: string id);

   /**
    * update moderationRequest in database
    **/
    RequestStatus updateModerationRequest(1: ModerationRequest moderationRequest);

    /**
     * set moderation state of moderation request specified by requestId to REJECTED
     * and sendMail to requestingUser about decline
     **/
    oneway void refuseRequest(1: string requestId);

    /**
     * remove user from moderators of moderation request specified by requestId,
     * set moderation state to PENDING,
     * unset reviewer
     **/
    oneway void removeUserFromAssignees(1: string requestId, 2:User user);

    /**
     * set moderation state to PENDING of moderation request spedified by requestId,
     * unset reviewer
     **/
    oneway void cancelInProgress(1: string requestId);

    /**
     * set moderation state of moderation request specified by requestId to IN PROGRESS,
     * set reviewer to user
     **/
    oneway void setInProgress(1: string requestId, 2:User user);

    /**
     * delete moderation requests for document specified by documentId from database
     **/
    oneway void deleteRequestsOnDocument(1: string documentId);

    /**
     * get list of moderation requests where user is one of the moderators
     **/
    list<ModerationRequest> getRequestsByModerator(1: User user);

    /**
     * get list of moderation requests where user is requesting user
     **/
    list<ModerationRequest> getRequestsByRequestingUser(1: User user);

    /**
     * delete moderation request specified by id if user is requesting user of moderation request
     **/
    RequestStatus deleteModerationRequest(1: string id, 2: User user);
}
