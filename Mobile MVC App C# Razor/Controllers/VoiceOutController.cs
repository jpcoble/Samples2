using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MobileComm.Models;

namespace MobileComm.Controllers
{

    [Authorize(Roles = "SuperUser")]

    public class VoiceOutController : Controller
    {
        private DB_9ABA01_voicetextEntities db = new DB_9ABA01_voicetextEntities();

        //
        // GET: /VoiceOut/

        public ActionResult Index()
        {
            return View(db.VoiceOuts.ToList());
        }

        //
        // GET: /VoiceOut/Details/5

        public ActionResult Details(int id = 0)
        {
            VoiceOut voiceout = db.VoiceOuts.Find(id);
            if (voiceout == null)
            {
                return HttpNotFound();
            }
            return View(voiceout);
        }

        //
        // GET: /VoiceOut/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /VoiceOut/Create

        [HttpPost]
        public ActionResult Create(VoiceOut voiceout)
        {
            if (ModelState.IsValid)
            {
                db.VoiceOuts.Add(voiceout);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(voiceout);
        }

        //
        // GET: /VoiceOut/Edit/5

        public ActionResult Edit(int id = 0)
        {
            VoiceOut voiceout = db.VoiceOuts.Find(id);
            if (voiceout == null)
            {
                return HttpNotFound();
            }
            return View(voiceout);
        }

        //
        // POST: /VoiceOut/Edit/5

        [HttpPost]
        public ActionResult Edit(VoiceOut voiceout)
        {
            if (ModelState.IsValid)
            {
                db.Entry(voiceout).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(voiceout);
        }

        //
        // GET: /VoiceOut/Delete/5

        public ActionResult Delete(int id = 0)
        {
            VoiceOut voiceout = db.VoiceOuts.Find(id);
            if (voiceout == null)
            {
                return HttpNotFound();
            }
            return View(voiceout);
        }

        //
        // POST: /VoiceOut/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            VoiceOut voiceout = db.VoiceOuts.Find(id);
            db.VoiceOuts.Remove(voiceout);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}