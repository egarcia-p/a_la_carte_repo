import React, { useState } from "react";
import PropTypes from "prop-types";

const RecipeIngredient = (props) => {
  const recipe_ingredient = props.recipe_ingredient;
  const section = props.section;
  const sectionIndex = props.sectionIndex;
  const ingredientIndex = props.ingredientIndex;
  const setSectionsMap = props.setSectionsMap;
  const [ingredientId, setIngredientId] = useState(
    recipe_ingredient.ingredient_id
  );
  const [quantity, setQuantity] = useState(recipe_ingredient.quantity);
  const [uomId, setUOMId] = useState(recipe_ingredient.uom_id);

  const updateValueIngredientId = (e) => {
    const value = e.target.value;
    setIngredientId(value);

    //Replace section ingredients
    const sectionsMapCopy = new Map(props.sectionsMap); // Get a copy of the sections array

    const recipeIngredientsCopy = [...section.recipe_ingredients];

    recipeIngredientsCopy.splice(ingredientIndex, 1, {
      id: recipe_ingredient.id,
      recipe_id: recipe_ingredient.recipe_id,
      ingredient_id: value,
      uom_id: recipe_ingredient.uom_id,
      quantity: recipe_ingredient.quantity,
      section_id: recipe_ingredient.section_id,
    });

    // Replace the current section item
    sectionsMapCopy.set(sectionIndex, {
      id: section.id,
      name: section.name,
      recipe_id: section.recipe_id,
      sort_number: section.sort_number,
      steps: section.steps,
      recipe_ingredients: recipeIngredientsCopy,
    });

    // Update the parent state
    setSectionsMap(sectionsMapCopy);
  };

  const updateValueUOMId = (e) => {
    const value = e.target.value;
    setUOMId(value);

    //Replace section ingredients
    const sectionsMapCopy = new Map(props.sectionsMap); // Get a copy of the sections array

    const recipeIngredientsCopy = [...section.recipe_ingredients];

    recipeIngredientsCopy.splice(ingredientIndex, 1, {
      id: recipe_ingredient.id,
      recipe_id: recipe_ingredient.recipe_id,
      ingredient_id: recipe_ingredient.ingredient_id,
      uom_id: value,
      quantity: recipe_ingredient.quantity,
      section_id: recipe_ingredient.section_id,
    });

    // Replace the current section item
    sectionsMapCopy.set(sectionIndex, {
      id: section.id,
      name: section.name,
      recipe_id: section.recipe_id,
      sort_number: section.sort_number,
      steps: section.steps,
      recipe_ingredients: recipeIngredientsCopy,
    });

    // Update the parent state
    setSectionsMap(sectionsMapCopy);
  };

  const updateValueQuantity = (e) => {
    const value = e.target.value;
    setQuantity(value);

    //Replace section ingredients
    const sectionsMapCopy = new Map(props.sectionsMap); // Get a copy of the sections array

    const recipeIngredientsCopy = [...section.recipe_ingredients];

    recipeIngredientsCopy.splice(ingredientIndex, 1, {
      id: recipe_ingredient.id,
      recipe_id: recipe_ingredient.recipe_id,
      ingredient_id: recipe_ingredient.ingredient_id,
      uom_id: recipe_ingredient.uom_id,
      quantity: value,
      section_id: recipe_ingredient.section_id,
    });

    // Replace the current section item
    sectionsMapCopy.set(sectionIndex, {
      id: section.id,
      name: section.name,
      recipe_id: section.recipe_id,
      sort_number: section.sort_number,
      steps: section.steps,
      recipe_ingredients: recipeIngredientsCopy,
    });

    // Update the parent state
    setSectionsMap(sectionsMapCopy);
  };

  return (
    <div className="recipe_ingredient">
      <label htmlFor="ingredient">Ingredient</label>
      <input
        type="text"
        name="ingredient_id"
        value={ingredientId}
        id="ingredientId"
        className="form-control"
        required
        onChange={updateValueIngredientId}
      />
      <label htmlFor="uom">UOM</label>
      <textarea
        type="text"
        name="uom_id"
        value={uomId}
        id="uomId"
        className="form-control"
        required
        onChange={updateValueUOMId}
      />
      <label htmlFor="quantity">Quantity</label>
      <textarea
        type="text"
        name="quantity"
        value={quantity}
        id="quantity"
        className="form-control"
        required
        onChange={updateValueQuantity}
      />
    </div>
  );
};

RecipeIngredient.propTypes = {
  recipe_ingredient: PropTypes.object,
  section: PropTypes.object,
  sectionIndex: PropTypes.number,
  ingredientIndex: PropTypes.number,
  sectionsMap: PropTypes.shape({
    k0: PropTypes.arrayOf(PropTypes.number),
    k1: PropTypes.arrayOf(PropTypes.string),
  }),
  setSectionsMap: PropTypes.func,
};

export default RecipeIngredient;
