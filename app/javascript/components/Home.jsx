import React, { useEffect, useState, useCallback } from "react";
import qs from "query-string";
import SelectFilterComponent from "./SelectFilter";
import apiClient from '../services/client';

const DEBOUNCE_DELAY = 300;

export default () => {
  // List of fetched companies
  const [companies, setCompanies] = useState([]);

  // Table filters
  const [companyName, setCompanyName] = useState("");
  const [industries, setIndustries] = useState("");
  const [minEmployee, setMinEmployee] = useState("");
  const [minimumDealAmount, setMinimumDealAmount] = useState("");
  const [limit, setLimit] = useState(10);

  // Debounce timeout
  const [debounceTimeout, setDebounceTimeout] = useState(DEBOUNCE_DELAY);

  // Fetch companies from API
  const fetchCompanies = useCallback(() => {
    const params = {
      name: companyName,
      industries: industries,
      employee_count: minEmployee,
      deal_amount: minimumDealAmount,
      limit: limit,
    };

    const queryParams = qs.stringify(params, {
      skipEmptyString: true
    });

    const url = `/api/v1/companies?${queryParams}`;
    apiClient(url)
      .then((res) => setCompanies(res.data))
      .catch((error) => console.error('Error fetching companies:', error));
  }, [companyName, industries, minEmployee, minimumDealAmount, limit]);

  useEffect(() => {
    if (debounceTimeout) {
      clearTimeout(debounceTimeout);
    }

    const newTimeout = setTimeout(() => {
      fetchCompanies();
    }, DEBOUNCE_DELAY);

    setDebounceTimeout(newTimeout);

    return () => {
      clearTimeout(newTimeout);
    };
  }, [companyName, industries, minEmployee, minimumDealAmount, limit]);


  const handleIndustriesChange = (selectedOptions) => {
    setIndustries(selectedOptions.map((option) => option.value).join(","));
  };

  return (
    <div className="vw-100 primary-color d-flex align-items-center justify-content-center">
      <div className="jumbotron fixed-width-app bg-transparent">
        <div className="container secondary-color pt-5">
          <h1 className="display-5">Companies</h1>

          <div className="row mb-2">
            <div className="col-md-8">
              <label htmlFor="company-name">Company Name</label>
              <div className="input-group">
                <input type="text" className="form-control" id="company-name" value={companyName} onChange={e => setCompanyName(e.target.value)} />
              </div>
            </div>
            <div className="col-md-4">
              <label htmlFor="min-employee">Minimum Employees</label>
              <div className="input-group mb-3">
                <input type="number" className="form-control" id="min-employee" step="1" value={minEmployee} onChange={e => setMinEmployee(e.target.value)} />
              </div>
            </div>
          </div>

          <div className="row mb-2">
            <div className="col-md-8">
              <label htmlFor="industries">Industry</label>
              <div className="input-group">
                <SelectFilterComponent dataPath="/api/v1/industries" onChange={handleIndustriesChange} />
              </div>
            </div>
            <div className="col-md-4">
              <label htmlFor="min-amount">Minimum Deal Amount</label>
              <div className="input-group flex-nowrap mb-3">
                <input type="number" className="form-control" id="min-amount" value={minimumDealAmount} onChange={e => setMinimumDealAmount(e.target.value)} />
                <span className="input-group-text" id="addon-wrapping">$</span>
              </div>
            </div>
          </div>

          <div className="row mb-2">
            <table className="table pt-4">
              <thead>
                <tr>
                  <th scope="col">Name</th>
                  <th scope="col">Industry</th>
                  <th scope="col" className="text-end">Employee Count</th>
                  <th scope="col" className="text-end">Total Deal Amount</th>
                </tr>
              </thead>
              <tbody>
                {companies.map((company) => (
                  <tr key={company.id}>
                    <td>{company.name}</td>
                    <td>{company.industry.name}</td>
                    <td className="text-end">{company.employee_count}</td>
                    <td className="text-end">{company.current_deals_amount} $</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          <div className="row">
            <div className="col-md-12 text-end">
              <label htmlFor="limit">Show</label>
              <select id="limit" className="form-control d-inline-block w-auto ms-2" value={limit} onChange={e => setLimit(e.target.value)}>
                <option value="10">10</option>
                <option value="20">20</option>
                <option value="50">50</option>
                <option value="100">100</option>
                <option value="1000">1000</option>
              </select>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
};
