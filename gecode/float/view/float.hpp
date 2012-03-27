/* -*- mode: C++; c-basic-offset: 2; indent-tabs-mode: nil -*- */
/*
 *  Main authors:
 *     Vincent Barichard <Vincent.Barichard@univ-angers.fr>
 *
 *  Copyright:
 *     Vincent Barichard, 2012
 *
 *  Last modified:
 *     $Date$ by $Author$
 *     $Revision$
 *
 *  This file is part of Gecode, the generic constraint
 *  development environment:
 *     http://www.gecode.org
 *
 *  Permission is hereby granted, free of charge, to any person obtaining
 *  a copy of this software and associated documentation files (the
 *  "Software"), to deal in the Software without restriction, including
 *  without limitation the rights to use, copy, modify, merge, publish,
 *  distribute, sublicense, and/or sell copies of the Software, and to
 *  permit persons to whom the Software is furnished to do so, subject to
 *  the following conditions:
 *
 *  The above copyright notice and this permission notice shall be
 *  included in all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 *  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 *  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 *  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 *  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 *  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 */

namespace Gecode { namespace Float {

  /*
   * Constructors and initialization
   *
   */
  forceinline
  FloatView::FloatView(void) {}
  forceinline
  FloatView::FloatView(const FloatVar& y)
    : VarImpView<FloatVar>(y.varimp()) {}
  forceinline
  FloatView::FloatView(FloatVarImp* y)
    : VarImpView<FloatVar>(y) {}

  /*
   * Value access
   *
   */
  forceinline FloatInterval
  FloatView::domain(void) const {
    return x->domain();
  }
  forceinline FloatNum
  FloatView::min(void) const {
    return x->min();
  }
  forceinline FloatNum
  FloatView::max(void) const {
    return x->max();
  }
  forceinline FloatVal
  FloatView::med(void) const {
    return x->med();
  }
  forceinline FloatNum
  FloatView::median(void) const {
    return x->median();
  }
  forceinline FloatVal
  FloatView::val(void) const {
    return x->val();
  }

  forceinline FloatNum
  FloatView::width(void) const {
    return x->width();
  }


  /*
   * Domain tests
   *
   */
  forceinline bool
  FloatView::zero_in() const {
    return x->zero_in();
  }
  forceinline bool
  FloatView::in(FloatNum n) const {
    return x->in(n);
  }
  forceinline bool
  FloatView::in(const FloatInterval& n) const {
    return x->in(n);
  }


  /*
   * Domain update by value
   *
   */
  forceinline ModEvent
  FloatView::lq(Space& home, int n) {
    return x->lq(home,n);
  }
  forceinline ModEvent
  FloatView::lq(Space& home, FloatNum n) {
    return x->lq(home,n);
  }
  forceinline ModEvent
  FloatView::lq(Space& home, FloatVal n) {
    return x->lq(home,n);
  }

  forceinline ModEvent
  FloatView::gq(Space& home, int n) {
    return x->gq(home,n);
  }
  forceinline ModEvent
  FloatView::gq(Space& home, FloatNum n) {
    return x->gq(home,n);
  }
  forceinline ModEvent
  FloatView::gq(Space& home, FloatVal n) {
    return x->gq(home,n);
  }

  forceinline ModEvent
  FloatView::eq(Space& home, int n) {
    return x->eq(home,n);
  }
  forceinline ModEvent
  FloatView::eq(Space& home, FloatNum n) {
    return x->eq(home,n);
  }
  forceinline ModEvent
  FloatView::eq(Space& home, const FloatVal& n) {
    return x->eq(home,n);
  }

  forceinline ModEvent
  FloatView::nq(Space& home, int n) {
    return x->nq(home,n);
  }
  forceinline ModEvent
  FloatView::nq(Space& home, FloatNum n) {
    return x->nq(home,n);
  }
  forceinline ModEvent
  FloatView::nq(Space& home, const FloatVal& n) {
    return x->nq(home,n);
  }


  /*
   * Delta information for advisors
   *
   */
  forceinline FloatNum
  FloatView::min(const Delta& d) const {
    return FloatVarImp::min(d);
  }
  forceinline FloatNum
  FloatView::max(const Delta& d) const {
    return FloatVarImp::max(d);
  }


  forceinline ModEventDelta
  FloatView::med(ModEvent me) {
    return VarImpView<FloatVar>::med(me);
  }

}}

// STATISTICS: float-var
