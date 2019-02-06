# library(rrtools)
# library(tidyverse)
library(data.table)
library(caret)

head(mtcars)

mt_data <- mtcars[complete.cases(mtcars),]

lm_mod <- train(mpg ~ .,
                data = mt_data,
                method = "lm",
                tuneLength = 3,
)

rf_mod <- train(mpg ~ .,
                data = mt_data,
                method = "ranger",
                tuneLength = 3,
                importance = "permutation",
)

models <- list("LM" = lm_mod,
               "RF" = rf_mod)

results <- resamples(models)
print(summary(results))
tvs <- Sys.getenv('TRAVIS_R_VERSION_STRING', unset = NA)
print(tvs)
pwd <- Sys.getenv('DB_PASS', unset = NA)
print(pwd)

# var_imp <- lapply(models, varImp)
#
# rank_func <- function(df, top){
#     df %>%
#         rownames_to_column(., "variable") %>%
#         mutate(Rank = frankv(Overall, order = -1),
#                Points = (top+1) - Rank) %>%
#         filter(Rank %in% c(1:top)) %>%
#         arrange(Rank)
# }
#
# rank_model_var <- lapply(var_imp, function(x) rank_func(x$importance, 4))
# str(ranked_imp)
#
# ranked_var <- bind_rows(rank_model_var) %>%
#     group_by(variable) %>%
#     summarise(Importance = sum(Points),
#               Count = n()) %>%
#     arrange(desc(Importance))
#
# top_var <- ranked_var %>%
#     top_n(., 4, Importance)
#
# selected_var <- top_var %>%
#     select(variable) %>%
#     distinct %>%
#     pull
#
# x_vars <- paste(selected_var, collapse = "+")
# y_var <- "mpg"
#
# form <- as.formula(paste(y_var, " ~ ", x_vars))
#
# new_lm <- train(form,
#                 data = mt_data,
#                 method = "lm",
#                 tuneLength = 3)
#
# new_rf <- train(form,
#                 data = mt_data,
#                 method = "ranger",
#                 tuneLength = 3)
#
# new_models <- list("new_LM" = new_lm,
#                    "new_RF" = new_rf)
#
# new_results <- resamples(new_models)
# summary(new_results)
#
# varImp(new_rf)

# ## rrtools
# # add all used packages
# usethis::use_package("caret")# "data.table", "caret"),
#                      # type = "Imports")
# # define a license
# usethis::use_mit_license(name = "Tomas Janik")
# # set up a git
# usethis::use_git()
# # if error, use local config
# usethis::use_git_config(scope = "project",
#                         user.name = "tomasjanikds",
#                         user.email = "tomas.janik.uk@gmail.com")
# # generate token in GitHub and paste it here: GITHUB_PAT = xxxx and empty new line
# usethis::edit_r_environ()
# # check if the token is stored
# Sys.getenv("GITHUB_PAT")
# # now set up repo in GitHub
# usethis::use_github(protocol = "https",
#                     private = FALSE)
# # readme file
# rrtools::use_readme_rmd()
# # build a tree
# rrtools::use_analysis()
# # add packages from paper.Rmd file
# rrtools::add_dependencies_to_description()
# add dockerfile
# rrtools::use_dockerfile()
# # add travisci
# rrtools::use_travis()
