@react.component
let make = () => {
  <div className="min-h-100 flex flex-col">
    <Header />
    <div className="flex-1 m-auto max-w-1000 py-8">
      <Router />
    </div>
    <Footer />
  </div>
}
