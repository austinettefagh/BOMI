public class mockEnqueueSnapshotService extends nforce.ACrossPackageService {
	@TestVisible
  //private SnapshotCaptureService snapshotCaptureSvc = new SnapshotCaptureService();

  public mockEnqueueSnapshotService() {
    this.addSupportedInputParameter(INPUT_PARAMETER_SOBJECTS, true, List<SObject>.class);
    this.addSupportedInputParameter(INPUT_PARAMETER_CONTEXT_IDS, true, Set<Id>.class);
  }

  public virtual override void execute() {
  
  }

  private final String INPUT_PARAMETER_CONTEXT_IDS = 'contextIds',
    INPUT_PARAMETER_SOBJECTS = 'sObjects';
}