import React, { useState } from "react";
import PropTypes from "prop-types";
import RecipeIngredient from "./RecipeIngredient";

const SectionNameInput = (props) => {
  return (
    <input
      type="text"
      name="name"
      value={props.name}
      className="form-control"
      required
      onChange={props.updateName}
    />
  );
};

const SectionIngredient = (props) => {
  const section = props.section;
  const sectionIndex = props.sectionIndex;
  const setSectionsMap = props.setSectionsMap;
  //const sections = props.sections;
  //const nameRef = useRef();
  const [name, setName] = useState(section.name);

  /*Event Handlers */
  const AddIngredientButton = () => {
    return <button onClick={onNewIngredientClick}>Add a new ingredient</button>;
  };

  function onNewIngredientClick() {
    const newIngredient = {
      recipe_id: section.recipe_id,
      ingredient_id: "",
      uom_id: "",
      quantity: 1,
      section_id: section.id
    };
    
    const sectionsMapCopy = new Map(props.sectionsMap); // Get a copy of the sections array

    const newSection = {
      id: section.id,
      name: section.name,
      recipe_id: section.recipe_id,
      sort_number: section.sort_number,
      steps: section.steps,
      recipe_ingredients: [...section.recipe_ingredients, newIngredient],
    };
    sectionsMapCopy.set(sectionIndex,newSection)
    
    setSectionsMap(sectionsMapCopy);
  }

  const updateName = (e) => {
    const value = e.target.value;
    setName(value);

    const sectionsMapCopy = new Map(props.sectionsMap); // Get a copy of the sections array
    // Replace the current section item
    const newSection = {
      id: section.id,
      name: value,
      recipe_id: section.recipe_id,
      sort_number: section.sort_number,
      recipe_ingredients: section.recipe_ingredients,
    };

    sectionsMapCopy.set(sectionIndex, newSection);

    // Update the parent state
    setSectionsMap(sectionsMapCopy);
  };

  console.log(section);

  return (
    <div className="section">
      <h2>Section Id: {section.id}</h2>
      <h1>
        Section Name: <SectionNameInput name={name} updateName={updateName} />
      </h1>

      <AddIngredientButton />
      <div className="ingredients">
        {section.recipe_ingredients.map((ingredient, index) => (
            <RecipeIngredient 
            key={index}
            recipe_ingredient={ingredient}
            section={section}
            sectionIndex={sectionIndex}
            ingredientIndex={index}
            sectionsMap={props.sectionsMap}
            setSectionsMap={setSectionsMap}
            ></RecipeIngredient>
        ))}
      </div>
    </div>
  );
};

SectionIngredient.propTypes = {
  section: PropTypes.object,
  sectionIndex: PropTypes.number,
  sectionsMap: PropTypes.shape({
    k0: PropTypes.arrayOf(PropTypes.number),
    k1: PropTypes.arrayOf(PropTypes.string),
  }),
  setSectionsMap: PropTypes.func,
};

SectionNameInput.propTypes = {
  name: PropTypes.string,
  updateName: PropTypes.func,
};

export default SectionIngredient;
