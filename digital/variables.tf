variable "myname" {
  type = string 
  default = "raph"
}

variable "allrg" {
    type = map 
    default = {
        Europe = {
            name = "rapheurope"
            location = "West Europe"
        },
        France = {
            name = "raphaelfrance"
            location = "france central"
        },
        US = {
            name = "raphaelus"
            location = "West US"
        }
        US = {
            name = "raphaelus"
            location = "West US"
        }
    }
}