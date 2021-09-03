package io.lumen.edgevm.model;

import lombok.Data;

@Data
public class ChangeInfo {
    private String createdDate;
    private String createdBy;
    private String modifiedDate;
    private String modifiedBy;
}
