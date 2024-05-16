import React, { useState, useEffect } from "react";
import Select from "react-select";
import apiClient from '../services/client';

const SelectFilterComponent = ({ dataPath, onChange }) => {
  const [options, setOptions] = useState([]);

  useEffect(() => {
    apiClient(dataPath)
      .then((res) =>  res.data)
      .then((data) => {
        const options = data.map((item) => ({
          value: item.id,
          label: item.name,
        }));
        setOptions(options);
      })
      .catch((error) => {
        console.error("Error fetching select data:", error);
      });
  }, []);

  return (
    <Select
      isMulti
      name="colors"
      options={options}
      className="form-control no-border-padding"
      classNamePrefix="select"
      dataPath={dataPath}
      onChange={onChange}
    />
  );
};

export default SelectFilterComponent;
