#=================================================================================================
# Class definition
#=================================================================================================


setClass(
  Class = "NominalVariable",
	contains = c("CategoricalVariable"),
  validity = function(object) {
    if(Dataset.globalenv$print.io) cat (" =>       NominalVariable: object validity check \n")
  	flag = TRUE
        
    if (nvalues(object) <= 2) {
      message("The variable must have at least three values")
      flag <- FALSE
    }
     
		return(flag)
	}
)


#=================================================================================================
# Class initializer
#=================================================================================================

  
#=================================================================================================
# Class standard constructeur
#=================================================================================================

nominalVariable <- function(
  x,
  missings,
  values,
  description,
  weights
){
  if(Dataset.globalenv$print.io) cat(" => (in)  NominalVariable: builder \n")
  
  out <- list(
    x = x,
    missings = missings,
    values = values,
    description = description,
    weights = weights
  )
  
  if(Dataset.globalenv$print.io) cat(" => (out) NominalVariable: builder \n")
  return(out)
}

nvar <- function(
  x,
  missings,
  values,
  description,
  weights
) {
  
  if(missing(missings)) missings <- numeric(0)
  if(missing(values)) values <- numeric(0)
  if(missing(description)) description <- character(0)
  if(missing(x)) x <- numeric(0)
  if(missing(weights)) weights <- numeric(0)
  
  # we apply special treatment for categorical variable
  variable <- categoricalVariable(
    x = x,
    missings = missings,
    values = values,
    description = description,
    weights = weights
  )
  # we apply special treatment for nominal variable
  variable <- nominalVariable(
    x = variable$x,
    missings = variable$missings,
    values = variable$values,
    description = variable$description,
    weights = variable$weights
  )
  
  out <- new(
    Class = "NominalVariable",
    codes = variable$x,
    missings = variable$missings,
    values = variable$values,
    description = variable$description,
    weights = variable$weights
  )
  message(paste('number of missings:',nmissings(out), '(', round(nmissings(out)/length(out)*100,2), '%)'))
  return(out)
}

is.nominal <- function(x){
  if(inherits(x, "NominalVariable")){
    return(TRUE)
  } else {
    return(FALSE)
  }
}


setMethod("summary", "NominalVariable", 
  definition = function (object, ...) {
    summary(as.vector(object))
  }
)
