package io.lumen.edgevm.model;

import lombok.Data;
import org.apache.commons.lang3.StringUtils;

import java.util.List;

@Data
public class Group {
    private String id;
    private String name;
    private String description;
    private String locationId;
    private String type;
    private int serversCount;
    private List<Group> groups;
    private List<Link> links;
    private ChangeInfo changeInfo;
    private List<CustomField> customFields;

    public Group findGroupByName(String groupName) {
        if (StringUtils.equalsIgnoreCase(this.name, groupName)) {
            return this;
        }

        return this.groups.stream()
                .filter(g -> {
                    Group group = g.findGroupByName(groupName);
                    return group != null && StringUtils.equalsIgnoreCase(group.getName(), groupName);
                })
                .findFirst().orElse(null);
    }
}
