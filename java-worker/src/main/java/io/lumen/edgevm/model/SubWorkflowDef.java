package io.lumen.edgevm.model;

import lombok.Builder;
import lombok.Data;

import java.util.Map;

@Data
@Builder
public class SubWorkflowDef {
    private String name;
    private String taskReferenceName;
    @Builder.Default
    private String type = "SUB_WORKFLOW";
    private Map<String, Object> inputParameters;
    private SubWorkflowParam subWorkflowParam;
}
