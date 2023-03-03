@react.component
let make = () => {
  <div className="flex flex-col justify-center h-auto">
    <Button.Group
      buttons=[
        {
          label: "Allocations Familiales",
          target: `/french-family-benefits`,
          isPrimary: true,
        },
        {
          label: "Aides Logements",
          target: `/french-housing-benefits`,
          isPrimary: false,
        },
      ]
    />
  </div>
}
