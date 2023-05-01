# Terraform Interview Questions

### Where is Terraform Used in DevOps?
* Terraform is a tool for building, changing and versioning infrastructure safely and efficiently. 
* Terraform can manage existing and popular cloud service providers as well as custom in-house solutions.
* Configuration files describe to Terraform the components needed to run a single application or your entire datacenter.

### What is Infrastructure as Code (IaC)?
* 'Infrastructure as Code (IaC)' is an approach to managing data center server, storage, and networking infrastructure. 
* IaC is meant to significantly simplify large-scale configuration and management. With traditional data center infrastructure management, every configuration change required manual action by operators and system administrators. With IaC, infrastructure configuration information is housed in standardized files, which can be read by software that maintains the state of the infrastructure. 
* IaC can improve productivity and reliability because it eliminates manual configuration steps.

### What is a Terraform module? 
* A Terraform module is a set of Terraform configuration files in a single directory. 
* Even a simple configuration consisting of a single directory with one or more .tf files is a module. 
* When you run Terraform commands directly from such a directory, it is considered the root module.

### What is State File Locking?
* State file locking happens automatically on all operations that could write state. 
* You won't see any message that it is happening. 
* If state file locking fails, Terraform will not continue. 
* You can disable state file locking for most commands with the -lock flag but it is not recommended.

### What is a Remote Backend in Terraform?
* Terraform stores state about managed infrastructure to map real-world resources to the configuration, keep track of metadata, and improve performance. 
* Terraform stores this state in a local file by default, but you can also use a Terraform remote backend to store state remotely.

### What is a Tainted Resource?
* The terraform taint command informs Terraform that a particular object has become degraded or damaged. 
* Terraform represents this by marking the object as "tainted" in the Terraform state, and Terraform will propose to replace it in the next plan you create.

### What steps should be followed for making an object of one module to be available for the other module at a high level?
1.First, in a resource configuration, an output variable must be defined. The scope of local and to a module is not declared until you declare resource configuration details.
2.You must now declare the output variable of module A so that it can be used in the configurations of other modules. You should create a brand new and current key name, and the value should be kept equal to the module A output variable.
3.You must now create a file variable.tf for module B. Create an input variable inside this file with the same name as the key you defined in module B. This variable in a module enables the resource’s dynamic configuration. Rep the process to make this variable available to another module as well. This is due to the fact that the variable established here has a scope limited to module B.

### Does Terraform support multi-provider deployments?
* Terraform lets you use the same workflow to manage multiple providers and handle cross-cloud dependencies. 
* This simplifies management and orchestration for large-scale, multi-cloud infrastructures.

### Define Resource Graph in Terraform?
* Terraform builds a dependency graph from the Terraform configurations, and walks this graph to generate plans, refresh state, and more. 
* This page documents the details of what are contained in this graph, what types of nodes there are, and how the edges of the graph are determined.

### How can you define dependencies in Terraform?
* You can use depends_on to explicitly declare the dependency. 
* You can also specify multiple resources in the depends_on argument, and Terraform will wait until all of them     have been created before creating the target resource.

### What happens when multiple engineers start deploying infrastructure using the same state file?
* Terraform has a very important feature called “state locking”. 
* This feature ensures that no changes are made to the state file during a run and prevents the state file from getting corrupt.

### Which value of the TF_LOG variable provides the MOST verbose logging?
* Terraform exposes the TF_LOG environment variable for setting the level of logging verbosity. 
* There are five levels: TRACE : the most elaborate verbosity, as it shows every step taken by Terraform and produces enormous outputs with internal logs.

* You can set TF_LOG to one of the log levels TRACE , DEBUG , INFO , WARN or ERROR to change the verbosity of the logs. 
* TRACE is the most verbose and it is the default if TF_LOG is set to something other than a log level name.

### Which command can be used to preview the terraform execution plan?
* The terraform plan command creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure.

### What is the benefit of Terraform State? What is the benefit of using modules in terraform?
* This means that it keeps track of everything it builds in your cloud environments so that if you need to change something or delete something later, Terraform will know what it built, and it can go back and make those changes for you. 
* That state is stored in what a state file .

* Terraform state is to store bindings between objects in a remote system and resource instances declared in your configuration. 

* Using modules in terraform you can save time and reduce costly errors

### What’s a null resource in Terraform?
* The null_resource implements the standard resource lifecycle but takes no further action. 
* The triggers argument allows specifying an arbitrary set of values that, when changed, will cause the resource to be replaced.

