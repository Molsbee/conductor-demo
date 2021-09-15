package io.lumen.edgevm.model;

import lombok.Builder;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
@Builder
public class WorkflowDef {
    private String name;
    private String description;
    private int version;
    private List<WorkflowTask> tasks;
    private Map<String, Object> outputParameters;
    private String failureWorkflow;
    private Boolean restartable;
    private Boolean workflowStatusListenerEnabled;
    @Builder.Default
    private int schemaVersion = 2;
}
