import React from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Home from "../components/Home";
import Recipes from "../components/recipes/Recipes";
import Recipe from "../components/recipes/Recipe";
import NewRecipe from "../components/recipes/new/NewRecipe";
import Tags from "../components/tags/Tags";
import NewTag from "../components/tags/NewTag";
import EditTag from "../components/tags/EditTag";
import Categories from "../components/categories/Categories";
import NewCategory from "../components/categories/NewCategory";
import EditCategory from "../components/categories/EditCategory";
import Subcategories from "../components/subcategories/Subcategories";
import NewSubcategory from "../components/subcategories/NewSubcategory";
import EditSubcategory from "../components/subcategories/EditSubcategory";
import RecipeSteps from "../components/recipes/new/RecipeSteps";

export default (
  <Router>
    <Switch>
      <Route path="/" exact component={Home} />
      <Route path="/recipes" exact component={Recipes} />
      <Route path="/recipe/:id" exact component={Recipe} />
      <Route path="/recipe" exact component={NewRecipe} />
      <Route path="/tags" exact component={Tags} />
      <Route path="/tag" exact component={NewTag} />
      <Route path="/tag/:id" exact component={EditTag} />
      <Route path="/categories" exact component={Categories} />
      <Route path="/category" exact component={NewCategory} />
      <Route path="/category/:id" exact component={EditCategory} />
      <Route path="/subcategories" exact component={Subcategories} />
      <Route path="/subcategory" exact component={NewSubcategory} />
      <Route path="/subcategory/:id" exact component={EditSubcategory} />
      <Route path="/recipe_steps/:id" exact component={RecipeSteps} />

    </Switch>
  </Router>
);